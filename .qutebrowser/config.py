import yaml

config_dir = str(config.configdir) + "/"
config.load_autoconfig()

################################
# Parse `config.yml`           #
################################

with open(config_dir + "config.yml", "r") as f:
  yaml_data = yaml.safe_load(f)

def dict_attrs(obj, path=""):
  if isinstance(obj, dict):
    for k, v in obj.items():
      yield from dict_attrs(v, "{}.{}".format(path, k) if path else k)
  elif isinstance(obj, list) and len(obj) == 1 and isinstance(obj[0], dict):
    yield path, obj[0]
  else:
    yield path, obj

for k, v in dict_attrs(yaml_data):
  config.set(k, v) 

################################
# Parse `keybinds.yml`         #
################################

with open(config_dir + "keybinds.yml", "r") as f:
  yaml_data = yaml.safe_load(f)

kb_unset = yaml_data["unset"]
for m, ks in kb_unset.items():
  for k in ks:
    c.bindings.default[m].pop(k, None)

c.bindings.commands = yaml_data["set"]

################################
# Parse misc. import files     #
################################

add_configs = [
  "nord-qutebrowser.py"
]

for f in add_configs:
  config.source(f)
