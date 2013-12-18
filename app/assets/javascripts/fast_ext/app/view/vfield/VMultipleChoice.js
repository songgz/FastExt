Ext.define('FastExt.view.vfield.VMultipleChoice', {
    extend:'Ext.form.field.ComboBox',
    valueObject: {},
    winCtx:{},
    winId:0,
    rest:{},

    valueField:'id',
    displayField:"title",
    forceSelection:true,
    multiSelect: true,
    triggerAction:'all',
    editable:false,
    selectOnFocus:true,

    initComponent:function () {
        this.fieldLabel = this.getFValue('title');
        this.name =  this.rest.getTableName() + '[' + this.getFValue('m_property').name.pluralize()+'][]';
        this.disabled = this.getFValue('readonly');
        this.allowBlank = true;
        this.store = this.getStore();
        this.callParent();
    },
    getStore:function () {
        var rest = Ext.create('FastExt.view.Rest', this.getMEntity().name);
        return new Ext.data.JsonStore({
            autoLoad:{start:0, limit:2},
            fields:['id', 'title'],
            proxy:{
                type:'ajax',
                url:rest.indexPath(),
                reader:{
                    type:'json',
                    root:'rows',
                    totalProperty:"totalCount"
                }
            }
        });
    },
    getMEntity:function(){
        return this.valueObject.m_property.m_datatype.m_entity;
    },
    getFValue:function (key) {
        return this.valueObject[key];
    }
});