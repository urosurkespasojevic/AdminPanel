using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using AdminPanel.DAL.Database;
using System.Data.Entity.Migrations;

namespace AdminPanel.DAL.Repository
{
    public class Repository<T> where T : class
    {
        #region Data members

        private AdminPanelContext context = null;

        #endregion

        #region Constructors

        public Repository(AdminPanelContext context)
        {
            this.context = context;
        }

        #endregion


        #region Public methods

        public IQueryable<T> Select<T>() where T : class
        {

            if (this.context != null)
            {
                return this.context.Set<T>().AsQueryable();
            }

            return null;
        }

        public bool Insert<T>(T entity) where T : class
        {
            if (entity == null)
            {
                return false;
            }

            if (this.context != null)
            {
                var isInserted = this.context.Set<T>().Add(entity);

                if (isInserted != null)
                {
                    //this.context.SaveChanges();
                    return true;
                }

                return false;
            }

            return false;
        }

        public bool Upadate<T>(T entity) where T : class
        {
            if (entity == null)
            {
                return false;
            }

            if (this.context != null)
            {
                this.context.Set<T>().AddOrUpdate(entity);
                return true;
            }

            return false;
        }

        public bool Delete<T>(T entity) where T : class
        {
            if (entity == null)
            {
                return false;
            }

            if (this.context != null)
            {

                var updatedObject = this.context.Set<T>().Attach(entity);
                var entry = this.context.Entry(entity);
                entry.State = EntityState.Deleted;
                //this.context.SaveChanges();

                return true;
            }

            return false;

        }


        #endregion
    }
}
