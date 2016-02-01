# .bashrc
# vim: noic nolist

#trap 'echo "VARIABLE-TRACE> \$TMUX = \"$TMUX\""' DEBUG

# User specific aliases and functions



# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/local/opt/go/libexec/bin

[[ -x $HOME/u/run/findutils/bin/find ]] && alias 'find'="$HOME/u/run/findutils/bin/find"

PS1='\n\e[2m\e[32m\u\e[0m@\H\n[\w]\n:# '

OLDIFS=${IFS}
IFS=$'\n'
if [[ -d $HOME/u/run ]];
then
    PATH=$( find -L $HOME/u/run -maxdepth 3 -type d -name "bin" -or -name "sbin" | tr '\n' ':'| sed -e 's/:$//'):$PATH
    export MANPATH=$( find -L $HOME/u/run -type d -name "man" | tr '\n' ':' | sed -e 's/:$//'):$MANPATH

    for x in $( find -L $HOME/u/run -type d -name "include" );
    do 
        CFLAGS+="-I$x "; 
        LDFLAGS+="-L$( echo $x | sed -e 's/include/lib/' ) "; 
        PREPATH="$( echo $x | sed -e 's/include/bin/' ):$( echo $x | sed -e 's/include/sbin/' ):"
    done 

    PKG_CONFIG_PATH=$( find -L $HOME/u/run -type d -name 'pkgconfig' | tr '\n', ':')

    PATH="$PREPATH:$PATH"
    export LD_LIBRARY_PATH=$( find -L $HOME/u/run -type d -name "lib" | tr '\n' ':' | sed -e 's/:$//' )$LD_LIBRARY_PATH
    export CFLAGS LDFLAGS LD_LIBRARY_PATH PKG_CONFIG_PATH
fi
IFS=${OLDIFS}

[[ -n $H ]] && cd $H && alias cdh="cd $H"

export EDITOR=/usr/local/bin/vim

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias log='more $VIRTUAL_ENV/uwsgi.log'

alias vm_restartdhcpd='sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --configure ;   
sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop;   
sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --start'  


export VUNDLE_URI='https://github.com/gmarik/vundle.git -b v0.10.2'
export GOPATH=$HOME/work/go
PATH=$PATH:$GOPATH/bin

export PYFLAKES_BUILTINS='__opts__,__salt__,__grains__,__pillar__,request'



colors(){
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}



DJANGO_ENVIRONMENT='local'

NATIVEPY='/usr/local/bin/python'
[[ -d "$HOME/.local/bin" ]] && PATH=$HOME/.local/bin:$PATH

VWRAP=/usr/local/bin/virtualenvwrapper.sh

export WORKON=$HOME/pyenv

if [[ -n $TMUX ]];
then
    VIRTUALENVWRAPPER_PYTHON=$NATIVEPY && . $VWRAP
    [[ -n $VIRTUAL_ENV ]] && . $HOME/.virtualenvs/set_prompt || . $VWRAP
else
   .  $VWRAP
fi

[[ -n $VIRTUAL_ENV ]] && . $VIRTUAL_ENV/../libvw

[[ -n "$THIS" ]] && workon ${THIS} && . $HOME/.virtualenvs/set_prompt &&
    [[ -f $H/.env ]] && . $H/.env

export EDITOR=$( which vim )
export DJANGO_ENV='local'

for x in /usr/local/etc/bash_completion.d/*;
do
    . $x
done

. $HOME/u/etc/skel/*.sh

function gi() { 
    curl -L -s https://www.gitignore.io/api/$@ ;
}


function watch_sphinx() {
    if [[ -d ./_build ]];
    then
        while [[ /dev/null ]];
        do
            [[ $( find . -type f -not -path "./_*/*" -mmin 0.083 ) ]] && make html 
            sleep 6
        done
    else
        echo "not a sphinx directory (no _build directory)"
    fi
}

export NVM_DIR="/Users/gladiatr/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -d /usr/local/opt/android-sdk ]] && export ANDROID_HOME=/usr/local/opt/android-sdk
alias gimp=/opt/homebrew-cask/Caskroom/gimp/2.8.14/GIMP.app/Contents/MacOS/GIMP
alias un='unset LD_LIBRARY_PATH CFLAGS PKG_CONFIG_PATH LDFLAGS; PATH=/usr/local/bin:/bin:/usr/bin'

