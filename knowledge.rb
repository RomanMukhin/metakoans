class Module
  def attribute(name, value = nil, &block)
    if name.is_a? Hash
      name.each {|key,value| attribute(key,value)}
    else      
      attr_writer name     
      define_method("#{name}") do 
        instance_variable_defined?("@#{name}") ? instance_variable_get("@#{name}") : (block_given? ? instance_eval(&block) : value)
      end     
      define_method("#{name}?") do
        !!send(name)
      end
    end
  end
end
