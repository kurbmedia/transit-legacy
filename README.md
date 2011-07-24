= Transit

Transit is a Rails 3.1 / MongoDB backed engine for creating content management systems. It operates around the concept that all content management can be 
broken down intwo types of models (called packages): a Post or a Page. 

Each *package* type can embed one or many `contexts` which are representations of a particular type of content included within that package.

== Posts

Posts are your standard blog/article/etc posts, which consist of a 
* title
* post date
* published/un-published status
* a *body* which defines the content that post contains.
* a *teaser* which is used as a "preview" of the post. On creation, a default is provided using the first paragraph of content from an associated Text context (see below).
* a slug which represents the url to the post. On creation, this field is automatically created from the title unless already provided.

By default posts do not include functionality for attaching images, though most of the time this is desired. See the **delivery options** section below for more info.

== Pages

Pages are the "standalone" version of a post. Whereas posts operate on a feed type system, pages are singular in nature and consist of
* a url (ie: slug). On creation, this field is automatically created from the title
* a title
* optional keywords
* description
* one or more *body* areas depending on the layout of the particular page.


== Content

Both package types associate (ie: embed) one or more `contexts` which, when combined, represent the content a particular package contains. 
Post based models implement contexts in an ordered fashion, where multiple contexts are displayed together, based on a (user/developer) defined `position` index. This 
allows content to be represented in a more dynamic nature, providing a flexible means of displaying anything from text, to video/audio, to whatever custom implementation 
without cramming everythign into some wysiwyg editor which, in all likelihood, will do nothing more than destroy a well crafted layout. 

**Delivering post content**

To deliver the content of a post-based package, use the `deliver` helper in your views. 
	
	<%= deliver(@post) %>
	
By default the helper will attempt to deliver content using one of the following... in order of priority:

1. If a `deliver` method exists on a context model, the result of that method will be output
2. If a helper method `deliver_context_class` exists, that helper method will be called. (ie: `deliver_audio` to output content on an Audio context)
3. Rendering the partial `contexts/context_class` passing it the local variable `context` (ie: `contexts/_audio.html.erb` for an Audio context)

=== Contexts

There are 3 contexts included in the core engine:

1. **Text**: Used to represent body copy / content
2. **Video**: Allows inserting video from multiple sources, whether file upload, youtube url, etc.
3. **Audio**: Same function as video... but included separately to allow for more custom output.

=== Creating Custom Contexts

To create a custom context, simply create a model that subclasses Transit::Context. By default this will provide the following fields:
* `name`: a String representing the name of the context, this is useful for display/organization purposes
* `meta`: a Hash which can be utilized to provide misc data / information about a context
* `body`: a String which represents the body of the context (ie html in a Text context). This is also aliased as `source` in Video and Audio contexts
* `position`: an Integer which represents the position of one context in relation to another. When displaying content in a Post, this defines the order in which each context will be output.

== Additional Items

=== Topics

Transit also includes a topic model which can be used to categorize posts. A topic can have many posts, and can be restricted to a particular type of post. 
Topics contain the following fields:
* `title`: a String representing the title/name of the topic
* `slug`: a String representing the topic name/title in a url friendly format. Automatically created on model creation unless defined
* `post_types`: an Array representing the model / classes that this topic can apply to. 

=== Comments

Since commenting is pretty much a de-facto standard in blogging these days, Transit includes a polymorphic comment model which can be used to assign comments to any other type of model (using the relationship `commentable`).
To utilize comments, your application will need to establish a `user` association.

=== Assets

To provide support for file and image uploads, a Transit::Asset model is provided. This model can accept any type of file upload, stored as the `file` field. 
The asset model also provides methods to determine whether a file is an `image?`, `video?`, or `audio?`. The asset model uses an `assetable` polymorphic relationship.

=== Owner

When more than one user is allowed to create Posts, implement this module to add *ownership* to any post-based package.

	class Article
	  include Mongoid::Document
	  deliver_as :post
	  deliver_with :owner
	end

== Delivery Options

When creating models in your application, use the `deliver_as` method to define the type of package that model implements:

	class Article
	  include Mongoid::Document
	  deliver_as :post
	end
	
	class StaticPage
	  include Mongoid::Document
	  deliver_as :page
	end
	
To add additional functionality to a package, use the `deliver_with` method. All of the options above under **Additional Items** utilize this method. When deliver_with is called, relationships are automatically created for the model 
they are applied to. 

	class Article
	  include Mongoid::Document
	  deliver_as :post
	  deliver_with :topics, :comments, :assets, :owner
	end
	
== Administration

As of version 0.0.3 the core library only includes views for `index` actions, which simply handle a table-based representation of a model. This allows for more flexibility in development, ensuring your 
management interfaces can be based on your/client needs/feedback rather than our opinion of what that should be. In the near future, an "add-on" library will be provided implementing our default 
admin views if you would like to integrate those as well. 

Transit does however generate controllers for management of resources, which are created in the `Transit` namespace, and subclass a top-level `TransitController`. 
Before actions in any of these controllers are run, the before_filter `authenticate_admin!` is processed to restrict access. Implement this method in your ApplicationController to handle that functionalty.

On load, Transit dynamically generates controllers for any model configured with the deliver_with option. Controllers are named using standard rails conventions, and subclass a controller with its respective 
package name. Using the example `Article` class above, Transit will generate `Transit::ArticlesController` which will subclass `Transit::PostsController`. Note that actual files for these controllers are not generated 
for you, they are simply dynamic classes registered with ActiveSupport::Dependencies so that Rails will utilize them in a normal manner. To override any functionality in these controllers, simply create the 
controller in your application, or override the top-level package controller.

Transit implements the awesome inherited_resources gem by Jose Valim. All of the helpers / methods / etc provided by inherited_resources are available to you.

== Pagination

Transit includes a simple pagination system based off of the great Kaminari gem. Paging is provided/created using native MongoDB limits and selectors. 

== Extras

Transit also adds a couple useful class methods to Mongoid Documents

`auto_increment` adds a `uid` field to a document, which functions like an auto_increment field in MySQL. On create each model is given a unique integer-based id in ascending order 
by utilizing Mongo's `max` selector.

`slug_with` allows creating url friendly strings from any field name. A `slug` field is automatically created.