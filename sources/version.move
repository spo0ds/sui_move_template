module template::version {

    // === Errors ===

    const EWrongVersion: u64 = 1001;
    const ENotAdmin: u64 = 1002; 

    // === Constants ===

    const VERSION_INIT: u64 = 1; 

    // === Structs ===
    
    public struct VERSION has drop {}

    public struct VAdminCap has key {
        id: UID
    }

    public struct Version has key, store {
        id: UID,
        version: u64,
        admin: ID
    }

    // === Init Function ===

    fun init(_witness: VERSION, ctx: &mut TxContext) {
        let adminCap = VAdminCap { id: object::new(ctx)};
        let adminCapId = object::id(&adminCap);

        transfer::transfer(adminCap, tx_context::sender(ctx));
        transfer::share_object(Version {
            id: object::new(ctx),
            version: VERSION_INIT,
            admin: adminCapId
        });
    }

    public fun checkVersion(version: &Version, modVersion: u64) {
        assert!(modVersion == version.version, EWrongVersion);
    }

    // === Admin Functions ===

    public entry fun migrate(admin: &VAdminCap, ver: &mut Version, newVer: u64){
        assert!(object::id(admin) == ver.admin, ENotAdmin);
        assert!(newVer > ver.version, ENotAdmin);
        ver.version = newVer
    }

    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(VERSION{}, ctx);
    }
}
