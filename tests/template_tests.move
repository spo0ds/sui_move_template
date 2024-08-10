#[test_only]
module template::template_tests {
    // imports
    use sui::test_scenario::{Self, Scenario};
    use std::debug::print;
    use template::template::{Self, Admin};
    use template::version::{Self, Version};

    // errors

    // roles
    const ADMIN: address = @0xAAAA;
    const USER: address = @0xBBBB;

    // tests
    #[test]
    fun test_() {
        let mut scenario= test_scenario::begin(ADMIN);
        let test = &mut scenario;
        let ctx = test_scenario::ctx(test);
        
        
        test_scenario::end(scenario);
    }

    #[test]
    fun test_2() {
        let mut scenario= test_scenario::begin(ADMIN);
        let test = &mut scenario;

        initialize(test, ADMIN);
        test_scenario::next_tx(test, ADMIN);
        {
            let admin_cap = test_scenario::take_from_sender<Admin>(test);

            test_scenario::return_to_sender(test, admin_cap);
        };
        let version = test_scenario::take_shared<Version>(test);
        test_scenario::next_tx(test, ADMIN);
        {   
    
        };
        test_scenario::return_shared(version);
        test_scenario::end(scenario);
    }

    fun initialize(scenario: &mut Scenario, admin: address) {
        test_scenario::next_tx(scenario, admin);
        {
            // call test_init function of your modules
            template::test_init(test_scenario::ctx(scenario));
            version::test_init(test_scenario::ctx(scenario));
        };
    }
}
