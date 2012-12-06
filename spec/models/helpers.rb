def change_attr_and_assert model, attr, value
	eval "model.#{attr} = value"
	model.save
	model.reload
	yield model.send attr
end

def change_attrs_and_assert model, attrs
	model.update_attributes attr
	model.save
	model.reload
	yield model attr
end
