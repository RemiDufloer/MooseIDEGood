Class {
	#name : #filterStubsSetting,
	#superclass : #MiBooleanSetting,
	#category : #'MooseIDE-Meta-ModelsBrowser'
}

{ #category : #settings }
filterStubsSetting class >> buildSettingNodeOn: aBuilder [

	<systemsettings>
	(aBuilder setting: self name)
		target: self;
		parent: #mooseIDE;
		default: true;
		description: self description;
		selector: #defaultValue;
		iconName: self iconName
]

{ #category : #accessing }
filterStubsSetting class >> defaultValue [

	^ true
]

{ #category : #accessing }
filterStubsSetting class >> description [

	^ 'If set to true, clicking Propagate will send to the bus a MooseGroup containing only the entities that are not stub.
If set to false, send the entire model.'
]

{ #category : #'as yet unclassified' }
filterStubsSetting class >> globalValue: aBoolean [

	
]

{ #category : #accessing }
filterStubsSetting class >> iconName [

	^ #mooseFilter
]

{ #category : #accessing }
filterStubsSetting class >> label [

	^ 'Filter out stubs?'
]

{ #category : #accessing }
filterStubsSetting class >> name [

	^ #filterStubsSetting
]

{ #category : #'as yet unclassified' }
filterStubsSetting >> globalValue: aBoolean [

	
]
