import requests
import sys

def get_repos_w_tags(repo):
    username = "joao"
    password = "12345"
    try:
        rv = {}
        base_url = f"http://192.168.37.143:5000/v2/{repo}"
        tags_response = requests.get(f"{base_url}/tags/list", auth=(username, password))
        tags_response.raise_for_status()
        tags = tags_response.json()["tags"]
        tags_ordenadas = sorted(tags)
        rv[repo] = tags_ordenadas
        return rv
    except requests.exceptions.RequestException as e:
        print(f"Erro ao fazer a requisição: {e}")
        return {}
    except KeyError:
        # Lida com o caso em que 'repositories' ou 'tags' não estão na resposta JSON.
        print("Erro: A chave 'repositories' ou 'tags' não foi encontrada na resposta JSON.")
        return {}

def main():
    # Função principal que executa a lógica do script.
    data = get_repos_w_tags(sys.argv[1])

    if data:
        for repo, tags in data.items():    # retorna uma lista de tuplas, onde cada tupla contém um par (chave, valor) do dicionário
            for tag in tags:
                print(f"  - {tag}")
    else:
        print("\nNenhum dado encontrado ou ocorreu um erro.")

if __name__ == "__main__":
    main()

