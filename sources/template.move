/// Module: template
module template::template {
    // imports
    use std::string::{utf8};
    use sui::display;
    use sui::package;
    use sui::event::emit;
    use template::version::{Version, checkVersion};

    // errors

    // constants
    const VERSION: u64 = 1;

    // one time witness
    public struct TEMPLATE has drop { }

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
    fun init(otw: TEMPLATE, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"description"), 
            utf8(b"url"),
        ];

        let values = vector[
            utf8(b"{name}"), 
            utf8(b"{description}"),
            utf8(b"{url}"), 
        ];

        let publisher = package::claim(otw, ctx); 
        let mut display = display::new_with_fields<Template_Struct>(
            &publisher, keys, values, ctx
        );
       
        display::update_version(&mut display);

        transfer::transfer(Admin {
            id: object::new(ctx)
        }, tx_context::sender(ctx));
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));
    }

    // public functions
    public fun create_template(version: &Version, ctx: &mut TxContext): Template_Struct {
        checkVersion(version, VERSION);

        let template_struct = Template_Struct {
            id: object::new(ctx)
        }; 

        emit(TemplateCreated {
            id: object::id(&template_struct)
        });

        template_struct
    }

    // private functions

    // getters

    // initializing for testing
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(TEMPLATE{}, ctx);
    }
}
