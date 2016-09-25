# -*- coding: utf-8 -*-
import scrapy
import html2text

STARTING = 'https://www.jobs.bg/front_job_search.php?first_search=1&is_region&cities[0]=1&categories[0]=15&all_type=0&all_position_level=1&all_company_type=1&keyword'

NEXT_URL = "https://www.jobs.bg/front_job_search.php?frompage={}&is_region=&cities%5B0%5D=1&categories%5B0%5D=15&all_type=0&all_position_level=1&all_company_type=1&keyword=#paging"

STEP = 15

FIELDS = [['description', 'Описание'],
          ['place', 'Месторабота'],
          ['company', 'Организация']]
FIELDS_SMALL = [['publicated', 'Дата'],
                ['category', 'Категория'],
                ['type', 'Вид работа'],
                ['level', 'Ниво'],
                ['busy', 'Вид заетост']] + FIELDS


class GryphoncrawlSpider(scrapy.Spider):

    # Enumerator for the main pages
    @staticmethod
    def pages_enumerator():
        yield STARTING
        current_jobs_number = STEP
        while True:
            yield NEXT_URL.format(current_jobs_number)
            current_jobs_number += STEP

    name = "gryphonCrawl"
    domain = 'https://www.jobs.bg/'
    # start_urls = [STARTING]
    start_urls = pages_enumerator.__func__()

    # Goes through main pages and job pages
    def parse(self, response):
        # Gets all jobs on the page.
        job_urls = self.get_job_urls(response)

        if not job_urls:
            yield self.process_job(response)

        # Enters here if on main pages
        while job_urls:
            job_url = type(self).domain + job_urls.pop(0)
            yield scrapy.Request(job_url, callback=self.parse)

    def get_job_urls(self, response):
        job_urls = []
        for job in response.css('a.joblink'):
            job_urls.append(job.css("a::attr(href)").extract()[0])
        return job_urls

    def process_job(self, response):
        data = {}
        job_title = response.xpath('//td[@class="jobTitle"]/text()').extract() or response.xpath('//h1[@class="catent"]/text()').extract()
        data['title'] = job_title
        converter = html2text.HTML2Text()
        for field in FIELDS_SMALL:
            row = response.xpath("//tr[contains(td, '{}')]".format(field[1]))[-1]
            data[field[0]] = converter.handle(row.css("td")[-1].extract())
        return data
