/// Module: template
module template::template {
    // imports

    // errors

    // Caps
    public struct Admin has key, store {
        id: UID,
    }

    // structs
    public struct Template_Struct has key, store {
        id: UID,
    }

    // Events
    public struct TemplateCreated has copy, drop {
        id: ID,
    }

    // constructor
    fun init(ctx: &mut TxContext) {
        transfer::transfer(Admin {
            id: object::new(ctx)
        }, tx_context::sender(ctx))
    }

    // public functions

    // private functions

    // getters

    // initializing for testing
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx);
    }
}
