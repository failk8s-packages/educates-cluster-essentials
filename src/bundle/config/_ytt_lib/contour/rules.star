def check_infra(val):
  if val["infraProvider"] in ["aws", "gcp", "azure"]:
    return val["service"]["type"] == "LoadBalancer" or fail("{} infra provider requires service.type to be LoadBalancer".format(val["infraProvider"]))
  end
  if val["infraProvider"] in ["kind", "minikube"]:
    return val["service"]["type"] == "ClusterIP" or fail("{} infra provider requires service.type to be ClusterIP".format(val["infraProvider"]))
  end
  return True
end

def check_host_ports(val):
  if val["infraProvider"] in ["kind"]:
    return val["service"]["useHostPorts"] == False or fail("{} infra provider requires service.useHostPorts to be False".format(val["infraProvider"]))
  end
  if val["infraProvider"] in ["aws", "gcp", "azure", "minikube"]:
    return val["service"]["useHostPorts"] == True or fail("{} infra provider requires service.useHostPorts to be True".format(val["infraProvider"]))
  end
  return True
end

def check_all(val):
  return check_infra(val) and check_host_ports(val)
end
