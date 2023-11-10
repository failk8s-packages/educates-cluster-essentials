# educates-cluster-essentials-package

This package provides educates-cluster-essentials functionality using [educates-cluster-essentials](https://github.com/vmware-tanzu-labs/educates-training-platform/tree/develop/carvel-packages/cluster-essentials).

## Components

- contour
- kyverno
- metacontroller
- external-dns
- cert-manager
- certs
- **TODO: registry**

## Configuration

The following configuration values can be set to customize the educates-cluster-essentials installation.

### Global

| Value       | Required/Optional | Description                                                   |
| ----------- | ----------------- | ------------------------------------------------------------- |
| `namespace` | Optional          | The namespace in which to deploy educates-cluster-essentials. |

## Test locally

If you want to get the output of the configuration to be applied, use:

```
ytt --data-values-file test.yaml  -f src/bundle/config
```

But if you want the internal configuration that is going to be used for specific infrastructure, use instead:

```
ytt --data-values-file test.yaml  -f src/bundle/config --data-value-yaml debug=True
```

**NOTE:** `--data-value-yaml debug=True` does enable output of the internal configuration to be used for the specific infra type.

## Usage Example

This walkthrough guides you through using educates-cluster-essentials...

**NOTE**: `develop` version of the package needs to comply with semver, hence the package will be versioned as `0.0.0+develop`

## Test in minikube

Start minikube:

```
minikube start
```

Install kapp-controller 0.20+

```
kubectl apply -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
```

Install the Package Metadata:

```
kubectl apply -f target/k8s
```

Install the Required RBAC for the package install (create the control NS):

```
kubectl apply -f target/test/packageinstall-ns-rbac.yaml
```

Create the configuration file for your cluster:

```
kubectl create secret generic educates-cluster-essentials -n educates-cluster-essentials-package --from-file=values.yaml=src/examples-values/minikube.yaml -o yaml --dry-run=client | kubectl apply -f -
```

Create the package:

```
kubectl apply -f target/test/packageinstall.yaml
```

Verify the installation:

```
watch kubectl get packageinstall -A
```

If there's an issue, you can verify the problem with:

```
kubectl get packageinstall educates-cluster-essentials -n educates-cluster-essentials-package -o yaml
```

## Develop checklist

1. Update your [config.json](./config.json) with the package info
2. Add [overlays](./src/bundle/config/overlays/) and [values](./src/bundle/config/values.yaml)
3. Test your bundle: `ytt --data-values-file src/example-values/minikube.yaml  -f src/bundle/config` providing a sample values file from [example-values](./src/examples-values/)
4. Build your bundle `./hack/build.sh`
5. Add it to the [failk8s-repo](https://github.com/failk8s-packages/failk8s-repo) and publish the new repo and test the package from there, or [test with local files](./target/test)

**NOTE**: `develop` versions will not be image locked and will have a version of 0.0.0+develop to comply with semver.
