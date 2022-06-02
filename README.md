Deploy a minikube cluster to test with.

```bash
minikube start --driver=hyperkit -p testargo
```

Deploy argocd 

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.3.4/manifests/install.yaml
```

Deploy our git server and check the status
```bash
kubectl apply -f ./gitops/gitserver.yaml
kubectl -n scm rollout status deploy/git-server
```

Setup port forwarding to access our git server from our localhost
```bash
#git_server=`kubectl -n scm get po -l app=git-server -oname | awk -F/ '{ print $2 }'`

#kubectl -n scm exec "${git_server}" -- git init /git/argocd-sample-setup.git

# Check that the files were cloned
#kubectl -n scm exec "${git_server}" -- ls -al /git/linkerd-examples.git

# Port forward to our git server
kubectl -n scm port-forward service/git-server 9418:9418  &

CWD=${PWD}
cd ..
git clone git://localhost/argocd-sample-setup.git  --no-checkout
cp argocd-sample-setup/.git ${CWD}
git add -A
git commit -m "initial commit"

```

Clone our repo
```bash
```

Add a remote to our server
```bash
git remote add git-server git://localhost/argocd-sample-setup.git
```

Now push to our remote
```bash
git push 
```