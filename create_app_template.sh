#!/bin/sh

### Simple helper script to generate the files used for a new app that 
### supports dev, qa and prod config.
###

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
APP_DIR="apps"
ROOT_DIR=${SCRIPT_DIR}/${APP_DIR}/${1}
#BASE
mkdir -p ${ROOT_DIR}/base 
touch  ${ROOT_DIR}/base/${1}.yaml
cat << EOF >  ${ROOT_DIR}/base/kustomization.yaml
resources:
 - ${1}.yaml
EOF

# ENVS
mkdir -p  ${ROOT_DIR}/envs/{dev,qa,prod}
cat << EOF > ${ROOT_DIR}/envs/dev/kustomization.yaml
bases:
 - ../../base/

patchesStrategicMerge:
- development.yaml
EOF

cat << EOF > ${ROOT_DIR}/envs/qa/kustomization.yaml
bases:
 - ../../base/

patchesStrategicMerge:
- qa.yaml
EOF

cat << EOF > ${ROOT_DIR}/envs/prod/kustomization.yaml
bases:
 - ../../base/

patchesStrategicMerge:
- production.yaml
EOF
