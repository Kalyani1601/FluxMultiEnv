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
echo "Select the env to deploy: available options dev, qa, prod"
read env
echo "Environment entered : $env"
if [[ "$env" == "dev" ]]; then
  kubectl apply -f dev.yaml
elif [[ "$env" == "qa" ]]; then
  kubectl apply -f qa.yaml
elif [[ "$env" == "prod" ]]; then
  kubectl apply -f prod.yaml
else
  echo "Incorrect env selected! Exiting..."
  exit 1
fi
