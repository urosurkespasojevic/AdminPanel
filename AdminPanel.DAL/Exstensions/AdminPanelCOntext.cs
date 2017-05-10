using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdminPanel.DAL.Database
{
    public partial class AdminPanelContext
    {
        public AdminPanelContext(string connectionString):base(connectionString)
        {

        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
