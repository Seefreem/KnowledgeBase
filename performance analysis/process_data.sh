# 解析data：
sudo perf script -i perf.data &> "$1".unfold

# 符号折叠：
./stackcollapse-perf.pl "$1".unfold &> "$1".folded

# 生成svg图：
./flamegraph.pl "$1".folded > "$1".svg