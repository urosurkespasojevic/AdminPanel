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
    [Authorize]
    public class CategoryController : ApiController
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        public IQueryable<Category> Get()
        {
            return this.unitOfWork.NewsRepository.Select<Category>();
        }

        public Category Get(Guid id)
        {
            return this.unitOfWork.NewsRepository.Select<Category>().FirstOrDefault(c => c.ID == id);
        }

        public bool Post([FromBody] Category category)
        {
            if (category.ID == Guid.Empty)
            {
                category.ID = Guid.NewGuid();
            }
                        
            var isInserted = this.unitOfWork.NewsRepository.Insert<Category>(category);

            if (isInserted == true)
            {
                this.unitOfWork.Save();
                return true;
            }

            return false;
        }

        public bool Put(Guid id, [FromBody] News news)
        {
            news.ID = id;

            if (this.unitOfWork.NewsRepository.Select<News>().FirstOrDefault(n => n.ID == news.ID) == null)
            {
                return false;
            }

            news.Category = this.unitOfWork.CategoryRepository.Select<Category>().FirstOrDefault(c => c.ID == news.CategoryID);

            var isUpdated = this.unitOfWork.NewsRepository.Upadate<News>(news);

            if (isUpdated == true)
            {
                this.unitOfWork.Save();
                return true;
            }

            return false;
        }

        public bool Delete(Guid id)
        {
            var news = this.unitOfWork.NewsRepository.Select<News>().FirstOrDefault(n => n.ID == id);

            if (news == null)
            {
                return false;
            }

            var isDeleted = this.unitOfWork.NewsRepository.Delete<News>(news);

            if (isDeleted)
            {
                this.unitOfWork.Save();
                return true;
            }

            return false;
        }
    }
}
