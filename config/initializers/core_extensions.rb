class Hash
  #pass single or array of keys, which will be removed, returning the remaining hash
  def remove!(*keys)
    keys.each{|key| self.delete(key) }
    self
  end

  #non-destructive version
  def remove(*keys)
    self.dup.remove!(*keys)
  end
end

class Array
	def move_element(index = 0, delta = 1)
		# This method moves an element within the array
		# index = the array item you want to move
		# delta = the direction and number of spaces to move the item.
		# 
		# For example:
		# move_element(myarray, 5, -1); // move up one space
		# move_element(myarray, 2, 1); // move down one space
		# 
		# Returns true for success, false for error.

		index2, temp_item = nil

		# Make sure the index is within the array bounds
		if (index < 0 || index >= self.length)
			return false
		end

		# Make sure the target index is within the array bounds
		index2 = index + delta;
		if (index2 < 0 || index2 >= self.length || index2 == index)
    	return false
  	end

  	# Move the elements in the array
  	temp_item = self[index2]
  	self[index2] = self[index]
  	self[index] = temp_item

  	return true
	end
end
