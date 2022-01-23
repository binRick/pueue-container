VENV_DIR=${VENV_DIR:-~/.venv-pueue}
if [[ ! -f $VENV_DIR/bin/activate ]]; then
  python3 -m venv $VENV_DIR
fi
source $VENV_DIR/bin/activate

BD=$VENV_DIR/bin

if [[ ! -f $BD/yaml2json ]]; then pip3 install json2yaml; fi
if [[ ! -f $BD/j2 ]]; then pip3 install j2cli; fi
if [[ ! -f $BD/docker-compose ]]; then pip3 install docker-compose; fi

which docker-compose
docker-compose --version
