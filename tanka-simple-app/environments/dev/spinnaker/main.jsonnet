
local k = import 'k.libsonnet';
local params = import '../../../lib/spinnaker-params.libsonnet';



{
// create spinnaker namespace

spinnakerNamespace: k.core.v1.namespace.new(
    name=params.namespace
  ),

// Define Spinnaker Deck Deployment
  spinnakerDeckDeployment: k.apps.v1.deployment.new(
    name='spinnaker-deck',
    replicas=params.spinnakerDeckReplicas,
    containers=[
      k.core.v1.container.new(
        name='spinnaker-deck',
        image=params.spinnakerDeckImage
      )
      + k.core.v1.container.withPorts([
        k.core.v1.containerPort.new(params.spinnakerDeckPort)
      ])
    ]
  )
  + k.apps.v1.deployment.metadata.withNamespace(params.namespace)
  + k.apps.v1.deployment.spec.selector.withMatchLabels({app: 'spinnaker-deck'})
  + k.apps.v1.deployment.spec.template.metadata.withLabels({app: 'spinnaker-deck'}),

  // Define Spinnaker Gate Deployment
  spinnakerGateDeployment: k.apps.v1.deployment.new(
    name='spinnaker-gate',
    replicas=params.spinnakerGateReplicas,
    containers=[
      k.core.v1.container.new(
        name='spinnaker-gate',
        image=params.spinnakerGateImage
      )
      + k.core.v1.container.withPorts([
        k.core.v1.containerPort.new(params.spinnakerGatePort)
      ])
    ]
  )
  + k.apps.v1.deployment.metadata.withNamespace(params.namespace)
  + k.apps.v1.deployment.spec.selector.withMatchLabels({app: 'spinnaker-gate'})
  + k.apps.v1.deployment.spec.template.metadata.withLabels({app: 'spinnaker-gate'}),

  // Define Service for Spinnaker Deck
  spinnakerDeckService: k.core.v1.service.new(
    name='spinnaker-deck',
    selector={app: 'spinnaker-deck'},
    ports=[
      k.core.v1.servicePort.new(
        port=params.spinnakerDeckPort,
        targetPort=params.spinnakerDeckPort
      )
    ]
  )
  + k.core.v1.service.metadata.withNamespace(params.namespace),

  // Define Service for Spinnaker Gate
  spinnakerGateService: k.core.v1.service.new(
    name='spinnaker-gate',
    selector={app: 'spinnaker-gate'},
    ports=[
      k.core.v1.servicePort.new(
        port=params.spinnakerGatePort,
        targetPort=params.spinnakerGatePort
      )
    ]
  )
  + k.core.v1.service.metadata.withNamespace(params.namespace),
}

