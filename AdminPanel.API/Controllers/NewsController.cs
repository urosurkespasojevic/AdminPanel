

namespace AdminPanel.API.Controllers
{
    using DAL;
    using DAL.Database;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web.Http;
    using System.Web.Http.Description;

    //[Authorize]

    public class NewsController : ApiController
    {
        private UnitOfWork unitOfWork = new UnitOfWork();

        public IQueryable<News> Get()
        {
            return this.unitOfWork.NewsRepository.Select<News>();
        }

        public News Get(Guid id)
        {
            return this.unitOfWork.NewsRepository.Select<News>().FirstOrDefault(n=>n.ID == id);
        }

        [Authorize]
        public bool Post([FromBody] News news)
        {
            if(news.ID == Guid.Empty)
            {
                news.ID = Guid.NewGuid();
            }

            if (news.Category == null)
            {
                news.Category = this.unitOfWork.CategoryRepository.Select<Category>().FirstOrDefault(c => c.ID == news.CategoryID);
            }

            var isInserted = this.unitOfWork.NewsRepository.Insert<News>(news);
            
            if(isInserted == true)
            {
                this.unitOfWork.Save();
                return true;
            }

            return false;
        }

        [Authorize]
        public bool Put(Guid id,[FromBody] News news)
        {
            news.ID = id;

            if(this.unitOfWork.NewsRepository.Select<News>().FirstOrDefault(n=>n.ID == news.ID) == null)
            {
                return false;
            }

            news.Category = this.unitOfWork.CategoryRepository.Select<Category>().FirstOrDefault(c=>c.ID == news.CategoryID);

            var isUpdated = this.unitOfWork.NewsRepository.Upadate<News>(news);

            if(isUpdated == true)
            {
                this.unitOfWork.Save();
                return true;
            }

            return false;
        }

        [Authorize]
        public bool Delete(Guid id)
        {
            var news = this.unitOfWork.NewsRepository.Select<News>().FirstOrDefault(n => n.ID == id);

            if(news == null)
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
