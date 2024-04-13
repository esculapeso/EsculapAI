esa() {
    
    # Define the base 'project' variable
    export project="aipg"

    # Use the 'project' variable in other variables
    export conf="$HOME/.$project"
    export daemon="${project}d"  # Appends 'd' to the 'project' string for the daemon name
    export cli="$main/src/$project-cli"
    export pathd="$main/src/$daemon"
    export testnet="$conf/testnet_$project"
    
    if [ "$1" = "start" ]; then
        if [ "$2" = "v" ]; then
            $pathd
        else
            $pathd > /dev/null 2>&1 &
        fi
    elif [ "$1" = "conf" ]; then
        nano $conf/$project.conf
    elif [ "$1" = "tor" ]; then
        sudo nano /etc/tor/torrc
    elif [ "$1" = "stop" ]; then
        if [[ $2 =~ ^[0-9]+$ ]]; then
            kill -9 $2
        else
            $cli stop
        fi 
    elif [ "$1" = "restart" ]; then
        $cli stop
        $pathd > /dev/null 2>&1 &
    elif [ "$1" = "cli" ]; then
        $cli $2
    elif [ "$1" = "status" ]; then
        runs $daemon
    elif [ "$1" = "debug" ]; then
        if [ "$2" = "tail" ]; then
            if [[ $3 =~ ^[0-9]+$ ]]; then
                tail -n $3 $testnet/debug.log
            else
                tail $testnet/debug.log
            fi
        else
            nano $testnet/debug.log
        fi
    elif [ "$1" = "configure" ]; then
        ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" --prefix=/usr/local --with-boost=/opt/boost --with-boost-libdir=/opt/boost/lib
    elif [ "$1" = "search" ]; then
        grep $2 -i $testnet/debug.log
	elif [ "$1" = "remove" ]; then
        if [ "$2" = "testnet" ]; then
            rm -rf $testnet
        fi
    elif [ "$1" = "ls" ]; then
        if [ "$2" = "testnet" ]; then
            ls $testnet
        fi
    elif [ "$1" = "cd" ]; then
        if [ "$2" = "testnet" ]; then
            cd $testnet
        elif [ "$2" = "conf" ]; then
            cd $conf
        elif [ "$2" = "" ]; then
            cd $main
        fi
    else
        daqhelp
    fi
}