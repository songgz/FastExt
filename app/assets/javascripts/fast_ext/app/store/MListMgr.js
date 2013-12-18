Ext.define('FastExt.store.MListMgr', {
    singleton:true,
    _lists_:{},
    getStore:function (list_id) {
        var gs =  this._lists_[list_id];
        if(!gs){
            gs = this.createStore(list_id);
            this._lists_[list_id] = gs;
        }
        return gs;
    },
    createStore:function (list_id) {
        var store = new Ext.data.JsonStore({
            autoLoad:false,
            fields:['id', 'name', 'title'],
            proxy:{
                type:'ajax',
                url:'/fast_ext/m_list_items.json?list_name='+ list_id,
                reader:{
                    type:'json',
                    root:''
                }
            }
        });
        Ext.apply(Ext.data.Connection.prototype, {
            async:false
        });
        store.load();
        Ext.apply(Ext.data.Connection.prototype, {
            async:true
        });
        return store;
    }
});
