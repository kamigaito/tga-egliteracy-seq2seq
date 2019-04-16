# .bashrc

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
ROOT_DIR="/gs/hs0/tga-egliteracy/egs/seq2seq"
__conda_setup="$(CONDA_REPORT_ERRORS=false ${ROOT_DIR}'/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "${ROOT_DIR}/anaconda3/etc/profile.d/conda.sh" ]; then
        . "${ROOT_DIR}/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="${ROOT_DIR}/anaconda3/bin:${PATH}"
    fi
fi
unset __conda_setup
# <<< conda init <<<
