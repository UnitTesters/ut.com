title=Unit Testing Mule DataWeave Scripts with MUnit
date=2016-07-20
categories=MUnit
tags=DataWeave, Transform Message, Mule ESB
status=published
type=post
summary=Mule DataWeave script can do complex transformations and so must be unit tested to ensure expected results. This post will help you to get started with dataweave unit testing. 
~~~~~~

[DataWeave](https://docs.mulesoft.com/mule-user-guide/v/3.8/dataweave) is a powerful transformation language introduced with Mule Enterprise Edition 3.7. It allows you to transform data from one format to another and supports CSV, XML, JSON, Flat/Fixed Width (v3.8+) & Java. You can look at [these DataWeave Examples](https://docs.mulesoft.com/mule-user-guide/v/3.8/dataweave-examples) to see it in action.

Like any other code of programming world, it is always a good idea to unit test the DataWeave script you write. In this post, we will see how we can unit test the DataWeave code.


## Writing DataWeave Script

DataWeave script can be included in two ways into Mule flow - 

####1. Add an inline script -

```xml
<dw:transform-message doc:name="Transform Message">
            <dw:set-payload><![CDATA[%dw 1.0
%output application/java
---
{
	employees: payload.root.*employee map {
		
			name: $.fname ++ ' ' ++ $.lname,
			dob: $.dob,
			age: (now as :string {format: "yyyy"}) - 
					(($.dob as :date {format:"MM-dd-yyyy"}) as :string {format:"yyyy"})
		
	}
}]]></dw:set-payload>
        </dw:transform-message>
        
```

####2. Add script to file (.dwl) and refer with `resource` attribute -

```xml
 <dw:transform-message doc:name="Transform Message">
      <dw:set-payload resource="classpath:dwl/employees.dwl"/>
 </dw:transform-message>
```



I prefer using `resource` option for writing my DataWeave scripts. This has few advantages over `inline` option -

1. Script (.dwl) is reusable by other trasnform messages components by referring to same file.

2. Mule configuration xml file remains clean and readable.

3. Most important for us, that makes it possible to test the script as an unit of code.

4. Hmm, there may be more but I just don't know them yet :).

   ​


## Flow with DataWeave Script
To keep demonstration simple, we will use below flow that consumes an employees.xml and transforms it to a Java Map. During transformation it also calculate employee's age.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:file="http://www.mulesoft.org/schema/mule/file" xmlns:dw="http://www.mulesoft.org/schema/mule/ee/dw" xmlns="http://www.mulesoft.org/schema/mule/core" xmlns:doc="http://www.mulesoft.org/schema/mule/documentation"
	xmlns:spring="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd
http://www.mulesoft.org/schema/mule/file http://www.mulesoft.org/schema/mule/file/current/mule-file.xsd
http://www.mulesoft.org/schema/mule/ee/dw http://www.mulesoft.org/schema/mule/ee/dw/current/dw.xsd">

    <flow name="dataweave-testingFlow">
        <file:inbound-endpoint path="input" moveToDirectory="output" responseTimeout="10000" doc:name="File"/>
        <dw:transform-message doc:name="Transform Message">
            <dw:set-payload resource="classpath:dwl/employees.dwl"/>
        </dw:transform-message>
        <logger level="INFO" message="#[message.payloadAs(java.lang.String)]" doc:name="Logger"/>
    </flow>
</mule>
```

**DataWeave Script** - `employees.dwl`

```
%dw 1.0
%output application/java
---
employees: payload.root.*employee map {
		
			name: $.fname ++ ' ' ++ $.lname,
			dob: $.dob,
			age: (now as :string {format: "yyyy"}) - 
					(($.dob as :date {format:"MM-dd-yyyy"}) as :string {format:"yyyy"})
		
}
```



## First MUnit Test

We will use [MUnit](https://docs.mulesoft.com/munit/v/1.2.0/) for writing our unit test cases. If you haven't written any munit test cases before then you can take a look at [MUnit Tutorial](https://docs.mulesoft.com/munit/v/1.2.0/munit-short-tutorial).

To write our first unit test, we will create a new MUnit Test suite `src/test/munit/dataweave-testing-test-suite.xml` with below code -

```xml
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:dw="http://www.mulesoft.org/schema/mule/ee/dw" xmlns="http://www.mulesoft.org/schema/mule/core"
	xmlns:doc="http://www.mulesoft.org/schema/mule/documentation"
	xmlns:munit="http://www.mulesoft.org/schema/mule/munit" xmlns:spring="http://www.springframework.org/schema/beans"
	xmlns:core="http://www.mulesoft.org/schema/mule/core" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.mulesoft.org/schema/mule/munit http://www.mulesoft.org/schema/mule/munit/current/mule-munit.xsd
http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd
http://www.mulesoft.org/schema/mule/ee/dw http://www.mulesoft.org/schema/mule/ee/dw/current/dw.xsd">
	<munit:config name="munit" doc:name="MUnit configuration" />
	
  	<munit:test name="dataweave-testing-test-suite-dataweave-testingFlowTest"
		description="Test">
		<munit:set
			payload="#[getResource('sample_data/employees.xml').asStream()]"
			doc:name="Set Message" mimeType="application/xml" />
		<dw:transform-message doc:name="Transform Message">
			<dw:set-payload resource="classpath:dwl/employees.dwl" />
		</dw:transform-message>
		<munit:assert-on-equals expectedValue="#[2]"
			actualValue="#[payload.employees.size()]" doc:name="Assert Equals"
			message="Missing some employees" />
		<munit:assert-on-equals expectedValue="#[36]"
			actualValue="#[payload.employees[0].age]" doc:name="Assert Equals" />
	</munit:test>
</mule>

```



This code has a munit test `dataweave-testing-test-suite-dataweave-testingFlowTest`. You can see that we are not importing our actual flow config and that is because, we will add a `transform-message` component and refer to the same dataweave script resource `dwl/employees.dwl` that main flow uses (Reuse and unit testability of script!!). Here is what this test is doing -

1. Create a test message using sample xml file as payload. We can use MEL expression to read file as stream. **We will set the mimeType of message as "application/xml".** 
2. Transform the input xml to csv using `employees.dwl` script. As we are transforming it into java object, output of DW will be a HashMap with employee list. 
3. Assert the number of employees we except in dataweave output.
4. For first employee record, assert the expected value of age. This will ensure that our age calculation is working as expected.

> **Important:** Not setting mimeType on test message will cause DataWeave to throw below exception because DataWeave will recieve the input as binary input stream and wouldn't know how to interpret content of it.

```java
Message               : Exception while executing: 
	employees: payload.root.*employee map {
	           ^
Type mismatch for 'Value Selector' operator
     found :binary, :name
  required :datetime, :name or
  required :localdatetime, :name or
  required :object, :name or
  required :time, :name or
  required :array, :name or
  required :date, :name or
  required :localtime, :name or
  required :period, :name
Element               : /dataweave-testing-test-suite-dataweave-testingFlowTest/processors/1 @ 22f3f850-4d52-11e6-b92d-1a0124cf99a6:dataweave-testing-test-suite.xml:17 (Transform Message)
```



Now Run this as MUnit Test case and you should see it running successfully -

![MUnit Runner](http://image.prntscr.com/image/ac611f8e9d0a4a809c8ac8997a3187df.png)



## Writing Java Unit Test Case

For those who prefer to write java instead of XML, `FunctionalMunitSuite` class can be used to write the test case.

Let's create a `src/test/munit/dataweave-testing-munit.xml` mule config (not a munit xml suite) and add a test subflow with target dataweave component. We are using the same dwl resource file.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:dw="http://www.mulesoft.org/schema/mule/ee/dw" xmlns="http://www.mulesoft.org/schema/mule/core" xmlns:doc="http://www.mulesoft.org/schema/mule/documentation"
	xmlns:spring="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd
http://www.mulesoft.org/schema/mule/ee/dw http://www.mulesoft.org/schema/mule/ee/dw/current/dw.xsd">

    <sub-flow name="dataweave-testing-suiteSub_Flow">
        <dw:transform-message doc:name="Transform Message">
        	<dw:set-payload resource="classpath:dwl/employees.dwl"></dw:set-payload>
        </dw:transform-message>
    </sub-flow>
    
</mule>
```



Here is our java test case equivalent to our earlier xml test -

```java
package com.mms.mule.explore;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
import org.junit.Test;
import org.mule.DefaultMuleMessage;
import org.mule.api.MuleEvent;
import org.mule.munit.runner.functional.FunctionalMunitSuite;
import org.mule.transformer.types.MimeTypes;
import org.mule.util.FileUtils;

public class DataWeaveTests extends FunctionalMunitSuite {

	@Override
	protected String getConfigResources() {
		return "dataweave-testing-suite.xml";
	}
	
	@Test
	public void testDW() throws Exception{
		
		String payload = FileUtils.readFileToString(new File(DataWeaveTests.class.getClassLoader().getResource("sample_data/employees.xml").getPath()));
		
		MuleEvent event = testEvent(payload);
		//Setting MimeType is critical.
   ((DefaultMuleMessage)event.getMessage()).setMimeType(MimeTypes.APPLICATION_XML);
		
      //Call our test flow
		MuleEvent reply = runFlow("dataweave-testing-suiteSub_Flow", event);
		
		HashMap obj = reply.getMessage().getPayload(HashMap.class);
		List<Map> lst = (List<Map>) obj.get("employees");
      //Put some asserts
		MatcherAssert.assertThat(2, Matchers.equalTo(lst.size()));
		MatcherAssert.assertThat(36, Matchers.equalTo(lst.get(0).get("age")));
		
	}
}
```



## Verifying CSV content output

In previous example, dataweave output was Java map which is easy to verify. How about verifying CSV ouput? There are two two ways to verify CSV output -

#### Verify as Strings:

- After DataWeave, use `object-to-string` transformer to convert output to string.
- Split the content with new line (you may want to replace '\r\n' with '\n' before splitting)
- Verify values in array.

#### Use another dataweave to convert csv to map and then verify the map data:

Below munit flow adds another dataweave which outputs `application/java` and script is as simple as `(payload)` which converts the csv as is to java map. You can see in second debug screenshot below -

```xml
<munit:test name="dataweave-testing-test-suite-dataweave-csv-testingFlowTest"
		description="Test">
		<munit:set
			payload="#[getResource('sample_data/employees.xml').asStream()]"
			doc:name="Set Message" mimeType="application/xml" />
		<dw:transform-message doc:name="Transform Message">
			<dw:set-payload resource="classpath:dwl/employees2.dwl" />
		</dw:transform-message>
        <dw:transform-message doc:name="Transform Message">
            <dw:set-payload><![CDATA[%dw 1.0
%output application/java
---
(payload)]]></dw:set-payload>
        </dw:transform-message>
		<munit:assert-on-equals expectedValue="#[2]"
			actualValue="#[payload.size()]" doc:name="Assert Equals"
			message="Missing some employees" />
		<munit:assert-on-equals expectedValue="#['36']"
			actualValue="#[payload[0].age]" doc:name="Assert Equals" />
	</munit:test>
```



![MUnit Testing for DataWeave CSV](http://image.prntscr.com/image/0ef71e30d1e840bda3069a2531d607ec.png)



If you look at the second assert that verifies age and compare with that of earlier java testing, you will notice that expected value is defined as string literal `#['36']`  vs. number `#[36]`. **This is because, all values from CSV are transformed as String data type in MAP** and `#[36]` would cause test case to fail. To have strongly typed values, we can write a full mapping in second dataweave but I am skipping that step for now.

With this minimal setup, you can verify the data in your munit.



## Troubleshooting 

### org.threeten.bp.zone.TzdbZoneRulesProvider could not be instantiated while running Java Test case

If you are manipulating dates in your dataweave script and writing test cases in java, then you may see tests failing with below error -

```java
org.mule.api.MessagingException: org.threeten.bp.zone.ZoneRulesProvider: Provider org.threeten.bp.zone.TzdbZoneRulesProvider could not be instantiated (java.util.ServiceConfigurationError).
	at org.mule.execution.ExceptionToMessagingExceptionExecutionInterceptor.execute(ExceptionToMessagingExceptionExecutionInterceptor.java:42)
	at org.mule.execution.MessageProcessorNotificationExecutionInterceptor.execute(MessageProcessorNotificationExecutionInterceptor.java:108)
  ...
Caused by: java.util.ServiceConfigurationError: org.threeten.bp.zone.ZoneRulesProvider: Provider org.threeten.bp.zone.TzdbZoneRulesProvider could not be instantiated
	at java.util.ServiceLoader.fail(ServiceLoader.java:232)
	at java.util.ServiceLoader.access$100(ServiceLoader.java:185)
  ...
Caused by: org.threeten.bp.zone.ZoneRulesException: Unable to load TZDB time-zone rules: jar:file:/Users/manik/.m2/repository/org/threeten/threetenbp/1.2/threetenbp-1.2.jar!/org/threeten/bp/TZDB.dat
	at org.threeten.bp.zone.TzdbZoneRulesProvider.load(TzdbZoneRulesProvider.java:146)
	at org.threeten.bp.zone.TzdbZoneRulesProvider.<init>(TzdbZoneRulesProvider.java:87)
  ...
Caused by: org.threeten.bp.zone.ZoneRulesException: Data already loaded for TZDB time-zone rules version: 2014i
	at org.threeten.bp.zone.TzdbZoneRulesProvider.load(TzdbZoneRulesProvider.java:139)
	... 87 more
```



**Resolution:** This error is thrown when threetenbp library gets loaded twice. `TzdbZoneRulesProvider` is already available in java runtime and dataweave pulls this jar as its dependency. Simple resolution is to exclude this from maven dependency, modify dataweave plugin dependency in your pom -

```xml
		<dependency>
			<groupId>com.mulesoft.weave</groupId>
			<artifactId>mule-plugin-weave_2.11</artifactId>
			<version>${mule.version}</version>
			<scope>provided</scope>
			<exclusions>
				<exclusion>
					<groupId>org.threeten</groupId>
					<artifactId>threetenbp</artifactId>
				</exclusion>
			</exclusions>
		</dependency>
```



### ArrayIndexOutOfBound Exception when setting CSV payload

If you are testing CSV input payload with dataweave on windows, then you may get `ArrayIndexOutOfBound` exception. I think this is a bug due windows formatted EOL (\r\n) characters.

**Resolution:** You can use tools like notepad++ or dos2unix to convert your file to UNIX (\n) EOL format. I usually like to do it like below which makes test compatible with both formats -

```java
String payload = FileUtils.readFileToString(new File(DataWeaveTests.class.getClassLoader().getResource("sample_data/employees.csv").getPath()));
payload = payload.replace("\r\n", "\n");
```

## Source Code
Test Application source code is available on Github [here](https://github.com/UnitTesters/explore-mule)

## Conclusion

Unit Testing is crucial part of any software development. Mule ESB provides numerous components for system integrations and data transformation. In this post, we saw how we can write unit test cases for DataWeave (Transform Message) component and ensure the transformed data is as per expecations. I hope this will help you to write (almost) bug-free scripts :).



Feel free to comment and let me know your thoughts or questions. 
