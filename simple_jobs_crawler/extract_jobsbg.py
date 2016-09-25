# extracting jobs from jobs.bg

# imports
import requests
from bs4 import BeautifulSoup


BASE_URL = "https://www.jobs.bg/"

STARTING_URL = "https://www.jobs.bg/front_job_search.php?first_search=1&is_region=&cities%5B%5D=1&categories%5B%5D=15&all_type=0&all_position_level=1&all_company_type=1&keyword="


def get_joblinks_from_jobsbg():
    my_request = requests.get(STARTING_URL)
    soup = BeautifulSoup(my_request.text, "html.parser")
    joblinks = list(map(lambda x: x['href'], soup.find_all('a', {'class': 'joblink'})))
    print(len(joblinks))
    print(joblinks)
    process_job_by_joblink_in_sofia(joblinks[0])


def process_job_by_joblink_in_sofia(joblink):
    CURRENT_CITY = "Sofia"
    my_request = requests.get(BASE_URL + joblink)
    soup = BeautifulSoup(my_request.text, "html.parser")

    job = {
        # 'active':      None,
        'category':    None,
        'city':        None,
        'company':     None,
        'description': None,
        'level':       None,
        'publicated':  None,
        'title':       None,
    }

    blq = soup.find_all('td', {'class': 'jobTitleViewBold'})

    print(dir(blq))
    print(blq)

    job['category'] = soup.find('li', {'class': 'jobcat'}).contents[0]
    job['city'] = CURRENT_CITY
    job['company'] = soup.find('a', {'class': 'company_link'}).contents[0]
    # job['description'] = soup.find_all('td', {'class': 'jobDataView'}).contents
    job['title'] = soup.find('td', {'class': 'jobTitle'}).contents[0]


    print(job)


get_joblinks_from_jobsbg()
