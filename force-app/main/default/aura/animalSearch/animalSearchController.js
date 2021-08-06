({
	handleClick : function(component, event, helper) {
        var action = component.get('c.obtainAnimalById'); 
        action.setParams({
            "id" : component.get("v.idOfAnimal")
        });
		
        action.setCallback(this, function(a){
            var finalArr = [];
            var arr = [];
            for(let key in a.getReturnValue()[0]) {
                arr.push(key);
            }
            
            a.getReturnValue()
            console.log(a.getReturnValue()[0]);
            console.log(arr);
            arr.forEach(item => {
                var obj = {};
                obj.label = item.slice(-3) == '__c' ? item.slice(0, -3) : item;
                obj.fieldName = item;
                obj.type = 'text';
                finalArr.push(obj);
            });
            component.set("v.columns", finalArr);
            component.set("v.data", a.getReturnValue());
            if(a.getReturnValue().length == 0) {
                var b = component.get('c.showToast');
                    $A.enqueueAction(b);
            }
        });
        $A.enqueueAction(action);
        
	},
    
    handleInputChange: function(component, event, helper) {
        var elem = component.find("inp").get("v.value");
        component.set("v.idOfAnimal", elem);
        const regex = /[a-zA-Z0-9]{18}|[a-zA-Z0-9]{15}|^\d+$/g;
        const found = elem.match(regex);

        if(found == null) {
            component.set("v.isValid", false);
            component.set("v.isButtonDisabled", true);
        } else {
            component.set("v.isValid", true);
        }

        if(component.get("v.isValid") == false) {
            component.set("v.isButtonDisabled", true);
        } else {
            component.set("v.isButtonDisabled", false);
        }

    },

    showToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": "Error",
            "title": "Eror",
            "message": "There is no animals with this"
        });
        toastEvent.fire();
    }
    
    
})