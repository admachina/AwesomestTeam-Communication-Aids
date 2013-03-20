using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Threading;
using System.IO;
using System.Data.SQLite;

namespace MvcApplication1.Controllers
{
    public class FtpState
    {
        private ManualResetEvent wait;
        private FtpWebRequest request;
        private byte[] fileData;
        private Exception operationException = null;
        string status;

        public FtpState()
        {
            wait = new ManualResetEvent(false);
        }

        public ManualResetEvent OperationComplete
        {
            get { return wait; }
        }

        public FtpWebRequest Request
        {
            get { return request; }
            set { request = value; }
        }

        public byte[] FileData
        {
            get { return fileData; }
            set { fileData = value; }
        }
        public Exception OperationException
        {
            get { return operationException; }
            set { operationException = value; }
        }
        public string StatusDescription
        {
            get { return status; }
            set { status = value; }
        }
    }

    public class ValuesController : ApiController
    {
        const string rootPath = "C:\\Users\\Administrator\\Desktop\\FTPFiles\\";
        //const string rootPath = "C:\\temp\\";
        const string defaultTree = "<tree></tree>";

        private string GetFileFromPath(string path)
        {
            try
            {
                var stream = new StreamReader(rootPath + path);
                string s = stream.ReadToEnd();
                stream.Close();
                return s;
            }
            catch (Exception e)
            {
                return "Error:" + e.Message;
            }
        }

        private void WriteFileToPath(string path, string text)
        {
            try
            {
                var stream = new StreamWriter(rootPath + path);
                stream.Write(text);
                stream.Close();
            }
            catch (Exception e)
            {
                return;
            }
        }

        [HttpGet]
        [ActionName("therapists")]
        public IEnumerable<string> ListTherapists()
        {
            return Directory.GetDirectories(rootPath).Select(path => path.Substring(path.LastIndexOf("\\") + 1));
        }

        public class User
        {
            public int id;
            public string name;
        }

        [HttpGet]
        [ActionName("therapists")]
        public IEnumerable<User> ListProfileIds(string therapist)
        {
            string sqlitePath = rootPath + therapist + "\\profiles.sqlite";

            var conn = new SQLiteConnection("Data Source=" + sqlitePath + ";");
            conn.Open();
            var command = new SQLiteCommand("select profile_id, name from profiles", conn);
            var ids = command.ExecuteReader();

            List<User> profileIds = new List<User>();
            while (ids.Read())
            {
                profileIds.Add(new User { id = ids.GetInt32(0), name = ids.GetString(1) });
            }

            conn.Close();
            return profileIds;
        }

        // GET api/values
        [HttpGet]
        [ActionName("sqlite")]
        public string getSqlite(string therapist)
        {
            return GetFileFromPath(therapist + "\\profiles.sqlite");
        }

        [HttpPost]
        [ActionName("sqlite")]
        public void postSqlite(string therapist, string data)
        {
            WriteFileToPath(therapist + "\\profiles.sqlite", data);
        }

        [HttpGet]
        [ActionName("xml")]
        public string getXmlFromSqlite(string therapist, int profile)
        {
            string sqlitePath = rootPath + therapist + "\\profiles.sqlite";

            var conn = new SQLiteConnection("Data Source=" + sqlitePath + ";");
            conn.Open();
            var command = new SQLiteCommand("select tree_path from profile_tree where profile_id=" + profile, conn);
            string xmlpath = (string)command.ExecuteScalar();

            string xmlstring = GetFileFromPath(xmlpath);

            conn.Close();
            return xmlstring;
        }

        public class Data
        {
            public string s;
        }

        [HttpPost]
        [ActionName("xml")]
        public void postXmlToSqliteAndFile(string therapist, int profile, [FromBody]Data xmlData)
        {
            string sqlitePath = rootPath + therapist + "\\profiles.sqlite";

            var conn = new SQLiteConnection("Data Source=" + sqlitePath + ";");
            conn.Open();

            var command = new SQLiteCommand("select tree_path from profile_tree where profile_id=" + profile, conn);
            string xmlpath = (string)command.ExecuteScalar();

            conn.Close();

            WriteFileToPath(xmlpath, ((Data)xmlData).s);
        }

        [HttpPost]
        [HttpGet]
        [ActionName("addProfile")]
        public void addEmptyProfile(string therapist, string name)
        {
            string sqlitePath = rootPath + therapist + "\\profiles.sqlite";

            var conn = new SQLiteConnection("Data Source=" + sqlitePath + ";");
            conn.Open();
            var transaction = conn.BeginTransaction();
            var maxCommand = new SQLiteCommand("select max(profile_id) from profiles", conn, transaction);
            var result = maxCommand.ExecuteScalar();
            long profileNum = (long)result + 1;

            var xmlPath = therapist + "\\" + profileNum + "start.xml";

            var profileCommand = new SQLiteCommand("insert into profiles (profile_id, name, difficulty) values (" + profileNum + ", '" + name + "', 'Medium')", conn, transaction);
            profileCommand.ExecuteNonQuery();
            var xmlCommand = new SQLiteCommand("insert into profile_tree (profile_id, tree_path) values (" + profileNum + ", '" + xmlPath + "')", conn, transaction);
            xmlCommand.ExecuteNonQuery();
            transaction.Commit();
            conn.Close();

            WriteFileToPath(xmlPath, defaultTree);
        }
    }
}