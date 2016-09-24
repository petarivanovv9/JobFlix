# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class JobCrawlerItem(scrapy.Item):
    city = scrapy.Field()
    category = scrapy.Field()
    description = scrapy.Field()
    level = scrapy.Field()
    publicated = scrapy.Field()
    headline = scrapy.Field()
    company = scrapy.Field()
    # active = scrapy.Field()
