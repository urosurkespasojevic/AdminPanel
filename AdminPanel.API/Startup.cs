
using Microsoft.Owin;
using Microsoft.Owin.Cors;
using Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

[assembly: OwinStartup(typeof(AdminPanel.API.Startup))]
namespace AdminPanel.API
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //initializing the db context
            //AdminPanelProviders.Initialize("name=AdminPanelContext");

            var config = new HttpConfiguration();

            WebApiConfig.Register(config);

            ConfigureAuthZero(app);

            app.UseCors(CorsOptions.AllowAll);
            app.UseWebApi(config);
        }
    }
}