#!/bin/bash

if [ $# -eq 1 ]; then
    IMAGE_NAME=${1}
else
    echo "Nome da API eh obrigatorio"
    exit 1
fi

# Define o diretório do projeto como a base.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Nome do ambiente virtual e do script Python.
VENV_PATH="$DIR/meu_ambiente"
PYTHON_SCRIPT="$DIR/get_api.py"

# Argumento que você quer passar para o script Python.
#ARGUMENTO="exemplo_parametro"

# Ativa o ambiente virtual.
source "$VENV_PATH/bin/activate"

# Verifica se a ativação foi bem-sucedida.
if [[ $? -ne 0 ]]; then
    echo "Erro: Não foi possível ativar o ambiente virtual. Verifique o caminho."
    exit 1
fi

# Executa o script Python usando o interpretador do ambiente virtual.
# O '$?' verifica o código de saída do comando anterior.
#python "$PYTHON_SCRIPT" "$ARGUMENTO"
python "$PYTHON_SCRIPT" "$IMAGE_NAME"
if [[ $? -ne 0 ]]; then
    echo "O script Python falhou."
    deactivate # Desativa o ambiente virtual antes de sair.
    exit 1
fi

# Desativa o ambiente virtual.
deactivate

