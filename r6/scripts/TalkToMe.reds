import TalkToMe.Config.*

// Trigger chatter if the player object is within proximity in front of an npc

@wrapMethod(ReactionManagerComponent)
protected cb func OnPlayerProximityStartEvent(evt: ref<PlayerProximityStartEvent>) -> Bool {
    let target: ref<GameObject> = this.GetPlayerSystem().GetLocalPlayerControlledGameObject();
    let isDriving: Bool = VehicleComponent.IsMountedToVehicle(target.GetGame(), target);

    if this.m_inCrowd && !isDriving && this.IsTargetInFront(target, npcFov(), false)  {    
        let vo: CName = n"greeting";
        let facialReactionAnimFeature: ref<AnimFeature_FacialReaction> = new AnimFeature_FacialReaction();
        facialReactionAnimFeature.category = 3;
        facialReactionAnimFeature.idle = 1;
        this.m_facialCooldown = 2.00;
        this.ActivateReactionLookAt(target, false);

        AnimationControllerComponent.ApplyFeatureToReplicate(this.GetOwner(), n"FacialReaction", facialReactionAnimFeature);
        GameObject.PlayVoiceOver(this.GetOwner(), vo, n"Scripts:TriggerLookAtReaction");
    }
    return wrappedMethod(evt);
}
