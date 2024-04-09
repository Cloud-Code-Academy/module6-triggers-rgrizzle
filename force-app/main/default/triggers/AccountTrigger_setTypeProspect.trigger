trigger AccountTrigger_setTypeProspect on Account (before insert) {
    for (Account acc : Trigger.new) {

    if (String.isBlank(acc.Type)) {
        Acc.Type = 'Prospect';
    }

    }
}