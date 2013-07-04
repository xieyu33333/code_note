arr = [1,2,3,21,1,1,2,5,6,7,7]
b=[]
arr.each { |a| b.push a unless b.include? a }

Ruby‎一维数组去重.
当然,使用内置的arr.uniq & arr.uniq!方法最好
