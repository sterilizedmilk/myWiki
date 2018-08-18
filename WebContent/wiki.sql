CREATE TABLE `page` (
  `page_name` varchar(40) NOT NULL,
  `page_content` text NOT NULL,
  PRIMARY KEY (`page_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `nickname` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_name` varchar(40) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `log_type` varchar(20) NOT NULL,
  `log_time` datetime NOT NULL,
  `log_diff` int(11) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
