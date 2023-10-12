<?php

namespace Drupal\searchstax_studio_vue\Controller;
use Drupal\Core\Controller\ControllerBase;
/**
* Provides route responses for the Searchstudio page module.
*/
class SearchstaxStudioVueController extends ControllerBase {
 /**
  * Returns a simple message page.
  *
  * @return array
  *   A simple renderable array.
  */
 public function searchPage() {
  return [
    // Your theme hook name.
    '#theme' => 'searchstax_studio_vue',
  ];
 }
}