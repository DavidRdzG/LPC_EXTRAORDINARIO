# Importacion de modulos
import csv
import requests
from bs4 import BeautifulSoup
# Obtención de los datos mediante petición GET
URL = "https://realpython.github.io/fake-jobs/"
page = requests.get(URL)
# Analizamos el contenido HTML con BeautifulSoup
soup = BeautifulSoup(page.content, "html.parser")
results = soup.find(id="ResultsContainer")
# Buscar todos los elementos que el class "card-content"
job_elements = results.find_all("div", class_="card-content")
# Buscar todps los elementos que el h2 contenga en su texto
# la palabra "python"
python_jobs = results.find_all(
	"h2", string=lambda text: "python" in text.lower()
    )
# Buscar cada elemento que tengan referencia de python_jobs
# Y almacenarlo en python_jobs_elements
python_jobs_elements = [
    h2_element.parent.parent.parent for h2_element in python_jobs
    ]
# Mostrar información de python_jobs_elements   
with open('Resultados.csv','w') as resultados:
    for job_element in python_jobs_elements:	
        title_element = job_element.find("h2", class_="title")
        company_element = job_element.find("h3", class_="company")
        location_element = job_element.find("p", class_="location")
        # De la lista de elementos de la etiqueta "a" buscamos
        # el primer elemento que incluya href.
        link_url = job_element.find_all("a")[1]["href"]
        #print(company_element.text.strip())
        #print(location_element.text.strip())
        #print(title_element.text.strip())
        
        #print()
        data = title_element.text,company_element.text,location_element.text
        csv_writer = csv.writer(resultados)
        csv_writer.writerow(data)
        csv_writer.writerow("")


    