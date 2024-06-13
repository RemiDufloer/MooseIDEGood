Class {
	#name : #MiModelsFilterSetting,
	#superclass : #MiBooleanSetting,
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #settings }
MiModelsFilterSetting class >> buildSettingNodeOn: aBuilder [

	<systemsettings>
	(aBuilder setting: self id)
		target: self;
		parent: MiModelsBrowser menuItem;
		default: true;
		description: self description;
		selector: #defaultValue;
		iconName: self iconName
]

{ #category : #accessing }
MiModelsFilterSetting class >> defaultValue [

	^ true
]

{ #category : #accessing }
MiModelsFilterSetting class >> description [

	^ 'If set to true, clicking Propagate will send to the bus a MooseGroup containing only the entities that are not stub.
If set to false, send the entire model.'
]

{ #category : #accessing }
MiModelsFilterSetting class >> iconName [

	^ #mooseFilter
]

{ #category : #accessing }
MiModelsFilterSetting class >> id [

	^ #filterStubsSetting
]

{ #category : #accessing }
MiModelsFilterSetting class >> label [

	^ 'Filter out stubs?'
]
