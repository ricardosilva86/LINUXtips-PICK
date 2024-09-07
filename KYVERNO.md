# Polices do Kyverno 🎯

Este documento descreve as políticas do Kyverno utilizadas no projeto.

## Política: Bloquear usuário Root 🚫

**Arquivo:** `kyverno-non-root-pods.yaml`

**Descrição:** Esta política impede que contêineres sejam executados como root. Ela exige que a configuração `runAsNonRoot` seja definida como `true`.

**Manifesto:**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-root-user
spec:
  validationFailureAction: Audit
  failurePolicy: Fail
  rules:
    - name: check-runAsNonRoot
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "Running as root is not allowed. Set runAsNonRoot to true."
        pattern:
          spec:
            containers:
              - securityContext:
                  runAsNonRoot: true
```

## Política: Checar Assinatura da Image da Aplicação 🔏

**Arquivo:** `kyverno-allow-only-signed-images.yaml`

**Descrição:** Esta política verifica se as imagens de contêiner são assinadas. Ela exige que as imagens correspondam ao padrão `ricardosilva86/giropops-senhas*` e que tenham pelo menos um atestador. A chave pública do atestador é armazenada em um segredo do Kubernetes.

**Manifesto:**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: check-image-signature
spec:
  validationFailureAction: Audit
  background: false
  webhookTimeoutSeconds: 30
  failurePolicy: Fail
  rules:
    - name: check-signed-images
      match:
        any:
          - resources:
              kinds:
                - Pod
      verifyImages:
        - imageReferences:
            - "ricardosilva86/giropops-senhas*"
          attestors:
            - count: 1
              entries:
                - keys:
                    publicKeys: k8s://{{ .Release.Namespace }}/{{ .Values.kyverno.publicKeySecretName }}
```

## Política: Allow Specific Images ✅

**Arquivo:** `kyverno-trusted-registry.yaml`

**Descrição:** Esta política permite apenas imagens específicas do DockerHub e Bitnami. Ela valida que as imagens correspondam aos padrões `ricardosilva86/giropops-senhas*` ou `bitnami/redis-cluster*`.

**Manifesto:**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: allow-specific-images
spec:
  validationFailureAction: Audit
  failurePolicy: Fail
  background: false
  rules:
    - name: allow-dockerhub-image
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "Only specific images from DockerHub are allowed."
        pattern:
          spec:
            containers:
              - image: ".*ricardosilva86/giropops-senhas*"
    - name: allow-bitnami-image
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "Only specific images from Bitnami are allowed."
        pattern:
          spec:
            containers:
              - image: ".*bitnami/redis-cluster*"
```

## Política: Exige CPU e Memory Recursos definidos 🧠💾

**Arquivo:** `kyverno-require-resources.yaml`

**Descrição:** Esta política exige que todos os contêineres tenham limites de CPU e memória definidos.

**Manifesto:**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-cpu-memory-limits
spec:
  validationFailureAction: Audit
  failurePolicy: Fail
  rules:
    - name: validate-limits
      match:
        resources:
          kinds:
            - Pod
      validate:
        message: "CPU and memory limits are required"
        pattern:
          spec:
            containers:
              - name: "*"
                resources:
                  limits:
                    memory: "?*"
                    cpu: "?*"
```

> Todas as políticas estão disponíveis no diretório `politicas-kyverno` do projeto.  

> ⚠️ IMPORTANTE: No momento, essas politicas estão como `Audit`, ou seja, apenas informam as violações. Para aplicar as políticas, altere o campo `validationFailureAction` para `Enforce`.