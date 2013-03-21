using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace MvcApplication1
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.Routes.MapHttpRoute(
                name: "SQLiteApi",
                routeTemplate: "sqlite/{therapist}",
                defaults: new { therapist = RouteParameter.Optional, controller="values", action="sqlite"}
            );
            config.Routes.MapHttpRoute(
                name: "XMLApi",
                routeTemplate: "xml/{therapist}/{profile}",
                defaults: new { controller = "values", action="xml" }
            );
            config.Routes.MapHttpRoute(
                name: "AddApi",
                routeTemplate: "addProfile/{therapist}/{name}",
                defaults: new { therapist = RouteParameter.Optional, profile = RouteParameter.Optional, controller = "values", action = "addProfile" }
            );
            config.Routes.MapHttpRoute(
                name: "TherapistsApi",
                routeTemplate: "therapists/{therapist}",
                defaults: new { controller = "values", action = "therapists", therapist = RouteParameter.Optional }
            );
        }
    }
}
