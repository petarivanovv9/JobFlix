import scrapy
from scrapy.selector import HtmlXPathSelector
from job_crawler.items import JobCrawlerItem


class JobsbgSpider(scrapy.Spider):
    name = "jobsbg"
    allowed_domains = ["jobs.bg"]

    base_url = "https://www.jobs.bg/"
    start_urls = ["https://www.jobs.bg/front_job_search.php?first_search=1&is_region=&cities%5B%5D=1&categories%5B%5D=15&all_type=0&all_position_level=1&all_company_type=1&keyword="]

    def parse(self, response):
        # hxs = HtmlXPathSelector(response)
        jobs_links = response.xpath('//a[@class="joblink"]/@href').extract()

        print(40 * '<>')
        print(jobs_links)
        print(len(jobs_links))
        print(40 * '*')
        for link in jobs_links:
            print(link)
            break
        print("BOOOM")

    def parse_job(self, response):
        # print(self.make_requests_from_url(JobsbgSpider.base_url + job_id))
        # response = self.make_requests_from_url(JobsbgSpider.base_url + job_id)
        hxs = HtmlXPathSelector(response)
        item = JobCrawlerItem()
        item['headline'] = hxs.select('//td[@class="jobTitle"]').extract()
        return item
