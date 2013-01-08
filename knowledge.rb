class Module
  def attribute(arg,&block)
    
    argument, default= (arg.class == Hash ? [arg.keys.first,arg.values.first] : [arg,nil])
    var = "@#{argument}".to_sym
    instance_variable_set(var,default) 

    self.send :define_method, "#{argument}" do  
      if instance_variables.include?(var)
        return instance_variable_get var 
      else
        return block_given? ? instance_eval(&block) : default
      end
    end

    self.send :define_method, "#{argument}=" do |num| 
      instance_variable_set(var, num)
    end

    self.send :define_method, "#{argument}?" do
      !self.send("#{argument}").nil? 
    end  
  end
end