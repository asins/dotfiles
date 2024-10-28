function monitor_connections --argument-names protocol --description "监听网络连接端口"
    # 检查协议参数是否合法
    if not string match -r '(tcp|udp)' -- $protocol
        if not test -z "$protocol"
            echo "Wrong option!"
            return 1
        end
    end

    function on_exit
        tput clear
        exit 0
    end
    # 设置 Ctrl+C 中断处理
    trap on_exit INT

    set col (tput cols)

    while true
        tput clear
        lsof -nPi4$protocol | awk '
        NR > 1 {
            split($9, ip, "->")
            split(ip[1], ip1, ":")
            split(ip[2], ip2, ":")
            printf("%-10s%5s %-15s%1s%5s %1s %-15s%1s%5s %s\n", $1, $2, ip1[1], (NR > 1 ? ":" : ""), ip1[2], ip[2] != "" ? ">" : "", ip2[1], length(ip2) > 1 ? ":" : "", ip2[2], $10)
        }'
        tput cup 0 $col
        sleep 2
    end
end
