{include file="_header.tpl"}
{include file="_statusbar.tpl"}

<div class="container_24">
  <div class="clearfix">
    
    <div class="grid_4 alpha omega" style="background-color:#e6e6e6"> <!-- begin left nav -->
      <div id="nav-sidebar">
        <ul id="top-level-sidenav"><br />
        
        {if $post}
          <ul class="side-subnav">
            <li><br><a href="{insert name=dashboard_link}">Dashboard</a></li>
          </ul>
          <li>
          Post
          <form id="grid_search_form" action="{$site_root_path}post">
          <input type="hidden" name="t" value="{$post->post_id}" />
          <input type="hidden" name="n" value="{$post->network}" />
          <ul class="side-subnav">
          <li{if $smarty.get.v eq ''} class="currentview"{/if}>
          <a href="index.php?t={$post->post_id}&n={$post->network|urlencode}">Replies&nbsp;&nbsp;&nbsp;</a>
          </li>
          {if $post->reply_count_cache && $post->reply_count_cache > 1}
            <li id="grid_search_input">
            <input type="text" name="search" id="grid_search_sidebar_input" value="" style="margin-top: 3px;" size="10"/><input type="submit" href="#" class="grid_search" onclick="$('#grid_search_form').submit(); return false;" value="Search">
            </li>
          {/if}
          </form>
          </li>
        {/if}
        {if $sidebar_menu}
          {foreach from=$sidebar_menu key=smkey item=sidebar_menu_item name=smenuloop}
              <li{if $smarty.get.v eq $smkey} class="currentview"{/if}><a href="index.php?v={$smkey}&t={$post->post_id}&n={$post->network|urlencode}">{$sidebar_menu_item->name}&nbsp;&nbsp;&nbsp;</a></li>
            {/foreach}
              </li>
            </ul>
        {/if}

        </ul>
      </div>
    </div> <!-- end left nav -->

    <div class="thinkup-canvas round-all grid_20 alpha omega prepend_20 append_20" style="min-height:340px">
      <div class="prefix_1">

        {include file="_usermessage.tpl"}

        {if $data_template}
            {include file=$data_template}
            <div class="float-l">
              <!-- {if $next_page}
              <a href="{$site_root_path}index.php?{if $smarty.get.v}v={$smarty.get.v}&{/if}{if $smarty.get.u}u={$smarty.get.u}&{/if}{if $smarty.get.n}n={$smarty.get.n}&{/if}page={$next_page}" id="next_page">&#60; Older Posts</a>
              {/if}
              {if $last_page}
              | <a href="{$site_root_path}index.php?{if $smarty.get.v}v={$smarty.get.v}&{/if}{if $smarty.get.u}u={$smarty.get.u}&{/if}{if $smarty.get.n}n={$smarty.get.n}&{/if}page={$last_page}" id="last_page">Newer Posts  &#62;</a>
              {/if}-->
            </div>
        {else}

          {if $post}
            <div class="clearfix">
              <div class="grid_2 alpha">
                <div class="avatar-container">
                  <img src="{$post->author_avatar}" class="avatar2"/><img src="{$site_root_path}plugins/{$post->network|get_plugin_path}/assets/img/favicon.ico" class="service-icon2"/>
                </div>
              </div>

              <div class="grid_12">
                <div class="br" style="min-height:110px">
                  <div class="tweet pr">
                    {if $post->post_text}
                        {if $post->network == 'twitter'}
                          {$post->post_text|filter_xss|link_usernames_to_twitter}
                        {else}
                          {$post->post_text}
                          {if $post->is_protected}
                                <span class="sprite icon-locked"></span>
                          {/if}
                          
                        {/if}
                    {/if}
                  </div>

                  {if $post->link->expanded_url and !$post->link->image_src and $post->link->expanded_url != $post->link->url}
                    <div class="clearfix">
                      <a href="{$post->link->expanded_url}" title="{$post->link->expanded_url}">{$post->link->expanded_url}</a><span class="ui-icon ui-icon-newwin">
                    </div>
                  {/if}

                  {if $post->link->expanded_url}
                    {if $post->link->image_src}
                     <div class="pic" style="float:left;margin-right:5px;margin-top:5px;"><a href="{$post->link->url}"><img src="{$post->link->image_src}" style="margin-bottom:50px;"/></a></div>
                    {/if}
                     <span class="small"><a href="{$post->link->url}" title="{$post->link->expanded_url}">{if $post->link->title}{$post->link->title}{else}{$post->link->url}{/if}</a>
                    {if $post->link->description}<br><small>{$post->link->description}</small>{/if}</span>
                  {/if}
      
                  <div class="clearfix gray" id="more-detail" style="width:460px;">
                    {if $post->network eq 'twitter'}
                      <a href="http://twitter.com/{$post->author_username}/statuses/{$post->post_id}">
                    {/if}
                    {$post->adj_pub_date|date_format:"%b %e, %Y %l:%M %p"}
                    {if $post->network eq 'twitter'}
                      </a>
                    {/if}
                    
                    {if $post->location}from {$post->location}{/if}
                    {if $post->source}
                      via
                      {if $post->source eq 'web'}
                        Web
                      {else}
                        {$post->source}<span class="ui-icon ui-icon-newwin"></span>
                      {/if}
                    {/if}
                    {if $post->network eq 'twitter'}
                      <a href="http://twitter.com/intent/tweet?in_reply_to={$post->post_id}"><span class="ui-icon ui-icon-arrowreturnthick-1-w" title="reply"></a>
                      <a href="http://twitter.com/intent/retweet?tweet_id={$post->post_id}"><span class="ui-icon ui-icon-arrowreturnthick-1-e" title="retweet"></a>
                      <a href="http://twitter.com/intent/favorite?tweet_id={$post->post_id}"><span class="ui-icon ui-icon-star" title="favorite"></a>
                    {/if}
                    <!--{if $post->in_reply_to_post_id}<a href="{$site_root_path}post/?t={$post->in_reply_to_post_id}">In reply to</a>{/if}
                      {if $post->in_retweet_of_post_id}<a href="{$site_root_path}post/?t={$post->in_retweet_of_post_id}">In retweet of</a><br>{/if}
                    -->
                    {if $disable_embed_code != true}
                        <div>
                        Embed this thread:<br>
                        <textarea cols="55" rows="2" id="txtarea" onClick="SelectAll('txtarea');">&lt;script src=&quot;http{if $smarty.server.HTTPS}s{/if}://{$smarty.server.SERVER_NAME}{$site_root_path}api/embed/v1/thinkup_embed.php?p={$smarty.get.t}&n={$smarty.get.n|urlencode}&quot;>&lt;/script></textarea>
                        </div>
                        {literal}
                        <script type="text/javascript">
                        function SelectAll(id) {
                            document.getElementById(id).focus();
                            document.getElementById(id).select();
                        }
                        </script>
                        {/literal}
                    {/if}
                    
                  </div> <!-- /#more-detail -->
                </div>
              </div>

              <div class="grid_5 omega center keystats">
                <div class="big-number">
                    <h1>{$post->reply_count_cache|number_format}</h1>
                    <h3>replies in {$post->adj_pub_date|relative_datetime}</h3>
                </div>
              </div>
            </div> <!-- /.clearfix -->
          {/if} <!-- end if post -->
          
          {if $replies}
            <div class="prepend">
              <div class="append_20 clearfix bt">
                {include file="_post.word-frequency.tpl"}
                {if $replies}
                    {include file="_grid.search.tpl" version2=true}
                {/if}
                <div id="post-replies-div"{if $search_on} style="display: none;"{/if}><br />
                  <div id="post_replies clearfix">
                  {foreach from=$replies key=tid item=t name=foo}
                    {include file="_post.author_no_counts.tpl" post=$t scrub_reply_username=true}
                  {/foreach}
                
                  </div>
                </div>
                <script src="{$site_root_path}assets/js/extlib/Snowball.stemmer.min.js" type="text/javascript"></script>
                {if $search_on}<script type="text/javascript">grid_search_on = true</script>{/if}
                <script src="{$site_root_path}assets/js/word_frequency.js" type="text/javascript"></script>
                {if !$logged_in_user && $private_reply_count > 0}
                  <span style="font-size:12px">Not showing {$private_reply_count} private repl{if $private_reply_count == 1}y{else}ies{/if}.</span>
                {/if}
              </div>
            </div>
          {/if}
        {/if}

        <!--
        <div class="append prepend clearfix">
          <a href="{$site_root_path}index.php" class="tt-button ui-state-default tt-button-icon-left ui-corner-all">
            <span class="ui-icon ui-icon-circle-arrow-w"></span>
            Back home
          </a>
        </div>
          &nbsp;
        -->  
          
      </div> <!-- /.prefix_1 -->
    </div> <!-- /.thinkup-canvas -->
  </div> <!-- /.clearfix -->
</div> <!-- /.container_24 -->

  <script type="text/javascript" src="{$site_root_path}assets/js/linkify.js"></script>
  {if $replies}
    <script type="text/javascript">post_username = '{$post->author_username}';</script>
    <script type="text/javascript" src="{$site_root_path}assets/js/grid_search.js"></script>
  {/if}
{include file="_footer.tpl"}
