## 用assembler之前需要修改你的assembly code
## 以下是需要注意的地方！！！
1. 所有的register都必须写成$r+数字（从0到7）-- $r0 -> $r7
2. 所有的instruction必须根据我们notion上的填写 -- and, add, xor, rtl, load, store, beq, move （不然其他的无法识别）
3. 所有的 3 bits immediate都必须写成binary --- 000 -> 111
4. 所有的 6 bits immediate都必须写成binary --- 000000 -> 111111
5. 所有的beq后面跟的label都必须换成6 bits immediate，这个immediate需要根据你需要移动的距离和```PC_LUT.sv```里的index决定。比如你需要PC = PC + 4，在现在的LUT中，+4对应的是index 3，所以6 bits就会变成000011
6. 在算出所有的距离之后也记得把所有的label删掉。比如 out: 这种label是不能存在的
### 其他的可以参考 program3_assem.txt