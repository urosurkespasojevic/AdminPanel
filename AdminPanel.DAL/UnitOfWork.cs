using AdminPanel.DAL.Database;
using AdminPanel.DAL.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdminPanel.DAL
{
    public class UnitOfWork : IDisposable
    {
        private AdminPanelContext context = null;

        private bool disposedValue = false;

        #region Repositories

        private Repository<News> newsRepository;

        private Repository<Category> categoryRepository;

        private Repository<User> userRepository;

        private Repository<Role> roleRepository;

        #endregion

        #region Properties

        public Repository<News> NewsRepository
        {
            get
            {
                if(this.newsRepository == null)
                {
                    this.newsRepository = new Repository<News>(this.context);
                }

                return this.newsRepository;
            }
        }

        public Repository<Category> CategoryRepository
        {
            get
            {
                if (this.categoryRepository == null)
                {
                    this.categoryRepository = new Repository<Category>(this.context);
                }

                return this.categoryRepository;
            }
        }

        public Repository<User> UserRepository
        {
            get
            {
                if (this.userRepository == null)
                {
                    this.userRepository = new Repository<User>(this.context);
                }

                return this.userRepository;
            }
        }

        public Repository<Role> RoleRepository
        {
            get
            {
                if (this.roleRepository == null)
                {
                    this.roleRepository = new Repository<Role>(this.context);
                }

                return this.roleRepository;
            }
        }

        #endregion

        #region Constructor

        public UnitOfWork()
        {
            this.context = new AdminPanelContext();
        }

        #endregion

        #region Public methods

        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void Save()
        {
            this.context.SaveChanges();
        }

        #endregion

        #region Protected methods

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposedValue = true;
        }

        #endregion

    }
}
