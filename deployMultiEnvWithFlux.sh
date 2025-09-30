export GIT_USER="<replace withactual git user>"
export GIT_PASSWORD="<replace with original PAT token>"

echo "Create ns angular-multienv"
kubectl create ns angular-multienv

echo "Prepare before installing crds"
kubectl apply -k https://github.com/fluxcd/flux2/manifests/crds

echo "Create secret"
kubectl create secret generic  git-credentials --from-literal=username="$GIT_USER" --from-literal=password="$GIT_PASSWORD" -n angular-multienv

echo "Applying git repository"
kubectl apply -f gitrepository.yaml
echo "==============================="
echo "Applying all the envs dev, qa, prod"

echo "Applying Environment : dev"
kubectl apply -f dev.yaml
echo "Applying Environment : qa"
kubectl apply -f qa.yaml
echo "Applying Environment : prod"
kubectl apply -f prod.yaml
