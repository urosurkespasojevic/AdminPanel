using AdminPanel.DAL;
using AdminPanel.DAL.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AdminPanel.API.Controllers
{
    public class UserController : ApiController
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        public bool Post([FromBody] User user)
        {
            if(user == null)
            {
                return false;
            }

            var isExsist = this.unitOfWork.UserRepository.Select<User>().FirstOrDefault(u => u.Email == user.Email);

            var isInserted = false;

            if(isExsist == null)
            {
                user.ID = Guid.NewGuid();

                user.Role = this.unitOfWork.RoleRepository.Select<Role>().FirstOrDefault(r=>r.Name == "Admin");
                user.RoleID = user.Role.ID;

                isInserted = this.unitOfWork.UserRepository.Insert<User>(user);
            }

            return isInserted; 
        }
    }
}
