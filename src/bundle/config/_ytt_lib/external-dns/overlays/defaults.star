load("@ytt:data", "data")

def get_default_aws_args():
  args = [
    "--provider=aws",
    "--aws-zone-type={}".format(""),
    "--source=service",
    "--source=ingress",
    "--source=contour-httpproxy",
    "--policy={}".format(""),
    "--aws-prefer-cname",
    "--registry=txt",
    "--txt-prefix=txt",
    "--domain-filter={}".format(""),
    "--txt-owner-id={}".format("")
  ]

#!  if data.values.contour.useProxyProtocol:
#!    args.append("--use-proxy-protocol")
#!  end
#!
#!  if data.values.contour.logLevel == "debug":
#!    args.append("--debug")
#!  end

  return args
end
