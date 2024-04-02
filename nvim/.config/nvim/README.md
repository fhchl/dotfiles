## Install pynvim and invironment

  mamba create -n pynvim python
  mamba actiave pynvim
  pip install -r pynvim_requirements.txt

Make sure 

  vim.g.python3_host_prog = "/home/fhchl/micromamba/envs/pynvim/bin/python"

is set correctly in init.lua


