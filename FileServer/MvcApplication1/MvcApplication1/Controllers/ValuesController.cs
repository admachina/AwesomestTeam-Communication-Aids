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
        const string defaultTree = "<Tree><DisplayValue></DisplayValue><PrintValue></PrintValue><IsRoot>TRUE</IsRoot><IsGoUp>FALSE</IsGoUp><Children><Tree><DisplayValue>Letters</DisplayValue><PrintValue></PrintValue><IsRoot>true</IsRoot><IsGoUp>FALSE</IsGoUp><Children><Tree><DisplayValue>space</DisplayValue><PrintValue>space</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>RAIO</DisplayValue><PrintValue></PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children><Tree><DisplayValue>R</DisplayValue><PrintValue>R</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>A</DisplayValue><PrintValue>A</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>I</DisplayValue><PrintValue>I</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>O</DisplayValue><PrintValue>O</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>NTES</DisplayValue><PrintValue></PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children><Tree><DisplayValue>N</DisplayValue><PrintValue>N</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>T</DisplayValue><PrintValue>T</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>E</DisplayValue><PrintValue>E</PrintValue><IsRoot>FALSE</IsRoot><IsGoUp>FALSE</IsGoUp><Children></Children></Tree><Tree><DisplayValue>S</DisplayValue><PrintValue>S</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>H</DisplayValue><PrintValue>H</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>FMLD</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>F</DisplayValue><PrintValue>F</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>M</DisplayValue><PrintValue>M</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>L</DisplayValue><PrintValue>L</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>D</DisplayValue><PrintValue>D</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>PCUY</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>P</DisplayValue><PrintValue>P</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>C</DisplayValue><PrintValue>C</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>U</DisplayValue><PrintValue>U</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>Y</DisplayValue><PrintValue>Y</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>BWG</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>B</DisplayValue><PrintValue>B</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>W</DisplayValue><PrintValue>W</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>G</DisplayValue><PrintValue>G</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>Go Back</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>true</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>J</DisplayValue><PrintValue>J</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>K</DisplayValue><PrintValue>K</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>V</DisplayValue><PrintValue>V</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>Q</DisplayValue><PrintValue>Q</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>Z</DisplayValue><PrintValue>Z</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>X</DisplayValue><PrintValue>X</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>Go Back</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>true</IsGoUp><Children></Children></Tree></Children></Tree></Children></Tree><Tree><DisplayValue>Go Back</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>true</IsGoUp><Children></Children></Tree></Children></Tree></Children></Tree></Children></Tree><Tree><DisplayValue>Words</DisplayValue><PrintValue></PrintValue><IsRoot>true</IsRoot><IsGoUp>FALSE</IsGoUp><Children><Tree><DisplayValue>pronoun</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>I </DisplayValue><PrintValue>I </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>you </DisplayValue><PrintValue>you </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>we </DisplayValue><PrintValue>we </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree><Tree><DisplayValue>verb</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>would</DisplayValue><PrintValue>would</PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>like </DisplayValue><PrintValue>like </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>do </DisplayValue><PrintValue>do </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>know </DisplayValue><PrintValue>know </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>come </DisplayValue><PrintValue>come </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>can </DisplayValue><PrintValue>can </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>watch </DisplayValue><PrintValue>watch </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree></Children></Tree><Tree><DisplayValue>question</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>who </DisplayValue><PrintValue>who </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>what </DisplayValue><PrintValue>what </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>why </DisplayValue><PrintValue>why </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>where </DisplayValue><PrintValue>where </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>when </DisplayValue><PrintValue>when </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>how </DisplayValue><PrintValue>how </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree></Children></Tree></Children></Tree><Tree><DisplayValue>Other</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>a </DisplayValue><PrintValue>a </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>to </DisplayValue><PrintValue>to </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>over </DisplayValue><PrintValue>over </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>More...</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children><Tree><DisplayValue>not </DisplayValue><PrintValue>not </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>and </DisplayValue><PrintValue>and </PrintValue><IsRoot>false</IsRoot><IsGoUp>false</IsGoUp><Children></Children></Tree><Tree><DisplayValue>Go back</DisplayValue><PrintValue></PrintValue><IsRoot>false</IsRoot><IsGoUp>true</IsGoUp><Children></Children></Tree></Children></Tree></Children></Tree></Children></Tree></Children></Tree>";

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